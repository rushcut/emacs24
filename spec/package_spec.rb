# -*- coding: utf-8 -*-
require_relative 'spec_helper'

describe 'emacs24::package' do

  describe 'install from package' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'does install package' do
      expect(chef_run).to install_package('emacs')
    end
  end

end
