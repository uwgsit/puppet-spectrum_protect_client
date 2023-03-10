# frozen_string_literal: true

require 'spec_helper'

describe 'spectrum_protect_client' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      version = '8.1.15'
      let(:facts) { os_facts }
      let(:params) {
        {
          'version' => version,
        }
      }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_package('TIVsm-BA') }
      it { is_expected.to contain_package('TIVsm-API64') }

      it { is_expected.to contain_yum__versionlock("0:TIVsm-BA-#{version}") }
      it { is_expected.to contain_yum__versionlock("0:TIVsm-API64-#{version}") }

    end
  end
end
