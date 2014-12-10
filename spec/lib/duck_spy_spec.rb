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

  describe '#stub' do
    before(:each) { duck_spy.stub(method, &body) }

    context 'when stubbing the method foo' do
      let(:method) { :foo }

      context 'and a block that returns its first parameter' do
        let(:body) { ->(x) { x } }

        describe '#foo(5)' do
          subject { duck_spy.foo(5) }

          it { is_expected.to be 5 }
        end
      end

      context 'and a block that returns 42, and accepts no arguments' do
        let(:body) { ->{ 42 } }

        describe '#foo' do
          subject { duck_spy.foo }

          it { is_expected.to be 42 }
        end
      end
    end
  end

  describe '#behave_like' do
    before(:each) { duck_spy.behave_like(behavior) }

    context 'when passed the behavior that foo returns 42' do
      let(:behavior) { { foo: 42 } }

      describe '#foo' do
        subject { duck_spy.foo }

        it { is_expected.to be 42 }
      end

      context 'and passed another behavior that bar returns 35' do
        before(:each) { duck_spy.behave_like(bar: 35) }

        describe '#bar' do
          subject { duck_spy.bar }

          it { is_expected.to be 35 }
        end

        describe '#foo' do
          subject { duck_spy.foo }

          it { is_expected.to be 42 }
        end
      end
    end
  end
end
