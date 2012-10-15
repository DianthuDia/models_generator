require 'spec_helper'

describe ModelsGenerator::Configuration do
  shared_examples_for 'a configure object' do
    context 'by default' do
      it { should eq default }
    end

    context 'configured via config block' do
      before do
        ModelsGenerator.configure {|c| c.send "#{config_name}=", other}
      end

      it { should eq other }

      after do
        ModelsGenerator.configure {|c| c.send "#{config_name}=", default}
      end
    end
  end

  describe '#master_attrs' do
    subject { ModelsGenerator.config.master_attrs}
    let(:config_name) { :master_attrs }
    let(:default) { %w[name label value] }
    let(:other) { %w[name position] }
    it_behaves_like 'a configure object'
  end
  
  describe '#master_eval' do
    subject { ModelsGenerator.config.master_eval}
    let(:config_name) { :master_eval }
    let(:default) { '' }
    let(:other) { 'validate :name, :presence => true' }
    it_behaves_like 'a configure object'
  end
end

