# encoding: utf-8
#
# Cookbook Name:: emacs24
# Attributes:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['emacs24']['build_dir'] = '/opt/emacs24'
default['emacs24']['version'] = '24.3'
default['emacs24']['packages'] = []
default['emacs24']['install_method'] = 'source'

case node['platform']
when 'debian', 'ubuntu'
  default['emacs24']['packages'] = %w(libtinfo-dev)
when 'centos'
  if node['platform_version'].to_i >= 7.0
    default['emacs24']['install_method'] = 'package'
  end
end
