require './lib/duck_spy.rb'

shared_examples 'it knows about calls' do |expected_calls|
  describe '#calls' do
    subject { duck_spy.calls }

    it { is_expected.to match a_hash_including expected_calls }
  end
end

describe DuckSpy do
  subject(:duck_spy) { DuckSpy.new }

  context 'when passed to a single-parameter method' do
    let(:some_method) { ->(x) { body.(x) } }
    before(:each) do
      some_method.(duck_spy)
    end

    context 'that does not call anything on the duck spy' do
      let(:body) { ->(_) { } }

      it_behaves_like 'it knows about calls', {}
    end

    context 'that calls #foo on the spy' do
      let(:body) { ->(spy) { spy.foo } }

      it_behaves_like 'it knows about calls', foo: []
    end
  end
end
