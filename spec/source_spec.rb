# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'emacs24::source' do
  describe 'install with default attributes' do

    let(:chef_run) { ChefSpec::Runner.new.converge described_recipe }

    it 'does includes recipes' do
      expect(chef_run).to include_recipe('apt')
      expect(chef_run).to include_recipe('build-essential')
    end

    it 'does create build directory' do
      expect(chef_run).to create_directory('/opt/emacs24').with(
        mode: 0755,
        recursive: true)
    end

    it 'does download emacs package' do
      expect(chef_run).to create_remote_file(
        '/var/chef/cache/emacs.tar.gz').with(
        source: 'http://ftp.gnu.org/gnu/emacs/emacs-24.3.tar.gz',
        mode: '0644')
    end

    it 'does untar emacs package' do
      expect(chef_run).to run_execute('untar').with(
        cwd: '/opt/emacs24',
        command: 'tar --strip-components 1 -xzf /var/chef/cache/emacs.tar.gz')
    end

    it 'does build emacs' do
      expect(chef_run).to run_execute('configure and make').with(
        cwd: '/opt/emacs24',
        command: './configure && make')

      expect(chef_run).to run_execute('make install').with(
        cwd: '/opt/emacs24',
        command: 'sudo make install')
    end
  end
  describe 'install with overriden attributes' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['emacs24']['build_dir'] = '/opt/emacs-build'
        node.set['emacs24']['version'] = '24.4'
        node.set['emacs24']['packages'] = ['libtinfo-dev']
      end.converge described_recipe
    end

    it 'does install libtinfo-dev package' do
      expect(chef_run).to install_package('libtinfo-dev')
    end

    it 'does create correct build directory' do
      expect(chef_run).to create_directory('/opt/emacs-build').with(
        mode: 0755,
        recursive: true)
    end

    it 'does download emacs package with correct version' do
      expect(chef_run).to create_remote_file(
        '/var/chef/cache/emacs.tar.gz').with(
        source: 'http://ftp.gnu.org/gnu/emacs/emacs-24.4.tar.gz',
        mode: '0644')
    end

    it 'does untar emacs package in correct build directory' do
      expect(chef_run).to run_execute('untar').with(
        cwd: '/opt/emacs-build',
        command: 'tar --strip-components 1 -xzf /var/chef/cache/emacs.tar.gz')
    end

    it 'does build emacs in correct build directory' do
      expect(chef_run).to run_execute('configure and make').with(
        cwd: '/opt/emacs-build',
        command: './configure && make')

      expect(chef_run).to run_execute('make install').with(
        cwd: '/opt/emacs-build',
        command: 'sudo make install')
    end
  end

end
