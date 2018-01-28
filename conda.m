% conda.m
% a simple MATLAB utility to control conda
% environments on *nix systems
% 
% usage
%
% MATLAB 			   Shell
% ===================================
% conda.getenv         conda env list
% conda.setenv(env)    source activate env
% 
% Srinivas Gorur-Shandilya 

classdef conda


properties
end

methods

end

methods (Static)

	function varargout = getenv()
		conda.addBaseCondaPath;
		[~,envs] = system(['conda env list']);
		envs = strsplit(envs,'\n');

		p = strsplit(getenv('PATH'),pathsep);

		% remove the asterix because it always is on root
		for i = length(envs):-1:1
			envs{i} = strrep(envs{i},'*',' ');
			if isempty(envs{i})
				continue
			end
			if strcmp(envs{i}(1),'#')
				continue
			end

			this_env = strsplit(envs{i});
			env_names{i} = this_env{1};
			env_paths{i} = this_env{2};

			for j = 1:length(p)
				this_env_path = [env_paths{j} '/bin'];
				if any(strcmp(this_env_path,p))
					active_path = j;
				end
			end

		end

		if nargout 
			varargout{1} = env_names;
			varargout{2} = env_paths;
			varargout{3} = active_path;
		else
			fprintf('\n')
			for i = 1:length(env_names)
				if isempty(env_names{i})
					continue
				end
				if active_path == i
					disp(['*' env_names{i} '     ' env_paths{i}])
				else
					disp([env_names{i} '     ' env_paths{i}])
				end
			end
		end


		% figure out which of these is first on the
		

	end

	function setenv(env)
		conda.addBaseCondaPath;
		[~,envs] = system(['conda env list']);
		envs = strsplit(envs,'\n');

		[env_names, env_paths] = conda.getenv;

		% check that envs exists in the list
		assert(any(strcmp(env_names,env)), 'env you want to activate is not valid')


		p = getenv('PATH');
		% delete every conda env path from the path
		p = strsplit(p,pathsep);
		rm_this = false(length(p),1);
		for i = 1:length(p)
			% remove "bin" from the end
			this_path = strtrim(strrep(p{i}, '/bin',''));
			if any(strcmp(this_path,env_paths))
				rm_this(i) = true;
			end
		end
		p(rm_this) = [];

		% add the path of the env we want to switch to
		this_env_path = [env_paths{strcmp(env_names,env)} '/bin'];
		p = [this_env_path p];
		p = strjoin(p,pathsep);
		setenv('PATH', p);

	end

	% this function makes sure that MATLAB knows about
	% the base Anaconda install, 
	% and that "conda" can be found on the path
	function addBaseCondaPath
		p = getenv('PATH');
		[~,home_path] = system('cd ~; pwd');
		% one of these should work
		a_path = strrep('~/anaconda/bin','~',strtrim(home_path));
		a3_path = strrep('~/anaconda3/bin','~',strtrim(home_path));
		if isempty(strfind(p,'anaconda'))
			% no anaconda at all on path
		    p = [a_path pathsep p];
		    p = [a3_path pathsep p];
		    setenv('PATH', p);
		else
			return
		end

		% now figure out where conda resolves to, and delete the other path
		[e,o] = system('which conda');
		assert(~logical(e), 'Could not locate conda')
		p = strsplit(getenv('PATH'),pathsep);
		if any(strfind(o,'anaconda3'))
			% remove a_path
			p(strcmp(p,a_path)) = [];
		else
			% remove a3_path
			p(strcmp(p,a3_path)) = [];
		end 
		p = strjoin(p,pathsep);
		setenv('PATH', p);
	end
	

end



end % end classdef