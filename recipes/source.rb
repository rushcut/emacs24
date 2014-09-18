include_recipe 'apt'
include_recipe 'build-essential'

node['emacs24']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

remotefile = 'http://ftp.gnu.org/gnu/emacs/emacs-'
remotefile << node['emacs24']['version'] << '.tar.gz'
localfile = Chef::Config[:file_cache_path] + '/emacs.tar.gz'

remote_file localfile do
  source remotefile
  mode '0644'
end

directory node['emacs24']['build_dir'] do
  mode 0755
  action :create
  recursive true
end

execute 'untar' do
  cwd node['emacs24']['build_dir']
  command 'tar --strip-components 1 -xzf ' + localfile
end

execute 'configure and make' do
  cwd node['emacs24']['build_dir']
  command './configure && make'
end

execute 'make install' do
  cwd node['emacs24']['build_dir']
  command 'sudo make install'
end
