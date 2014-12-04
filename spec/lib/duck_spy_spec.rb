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

      it_behaves_like 'it knows about calls', foo: { args: [], result_duck: {} }
    end

    context 'that calls #foo on the spy with 42 as an argument' do
      let(:body) { ->(spy) { spy.foo(42) } }

      it_behaves_like 'it knows about calls', foo: { args: [42], result_duck: {} }
    end

    context 'that calls #foo and #bar on the spy' do
      let(:body) { ->(spy) { spy.foo; spy.bar } }

      it_behaves_like 'it knows about calls', foo: { args: [], result_duck: {} }, bar: { args: [], result_duck: {} }
    end

    context 'that calls #foo on the spy, and #bar on the result' do
      let(:body) { ->(spy) { spy.foo.bar } }

      it_behaves_like 'it knows about calls', foo: { args: [], result_duck: { bar: {  args: [], result_duck: [] } } }
    end
  end
end
