require 'spec_helper'
require 'realtime'
require 'glu_plugin'
require 'chef_plugin'

describe Realtime do
  describe 'MessageHandler' do
    before :each do
      @handler = Realtime::MessageHandler.new
    end
    describe "handle" do
      describe "glu" do
        before :each do
          @mock_runner = mock(GluPlugin::Runner)
          GluPlugin::Runner.stub(:new) {@mock_runner}
        end
        it 'should handle glu messages' do
          @mock_runner.should_receive(:run_update).with('amq')
          runner = @handler.handle('{"source": "glu", "host": "nada"}')
          runner.should == @mock_runner
        end
      end
      describe "chef" do
        before :each do
          @mock_runner = mock(ChefPlugin::Runner)
          ChefPlugin::Runner.stub(:new) {@mock_runner}
        end
        it 'should handle chef messages' do
          @mock_runner.should_receive(:run_update).with('amq')
          runner = @handler.handle('{"source": "chef", "host": "nada"}')
          runner.should == @mock_runner
        end
      end
    end
  end
end
