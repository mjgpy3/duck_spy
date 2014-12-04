require './lib/duck_spy.rb'

describe DuckSpy do
  subject(:duck_spy) { DuckSpy.new }

  context 'when passed to a single-parameter method' do
    let(:some_method) { ->(x) { body.(x) } }
    before(:each) do
      some_method.(duck_spy)
    end

    context 'that does not call anything on the duck spy' do
      let(:body) { ->(_) { } }

      describe '#calls' do
        subject { duck_spy.calls }

        it { is_expected.to be_instance_of(Hash) }
        it { is_expected.to be_empty }
      end
    end
  end

end
