module PermissionPolicy
  RSpec.describe 'Authorization' do
    before do
      PermissionPolicy.configure do |c|
        c.precondition_attributes = [:my_user, :my_account]
      end
    end

    subject { PermissionPolicy::Authorization.new(context) }

    context 'valid' do
      let(:context) { double('context', my_user: 'foo', my_account: 'bar') }

      it 'sets attribute readers each precondition' do
        expect(subject.my_user).to eq('foo')
        expect(subject.my_account).to eq('bar')
      end
    end

    context 'invalid' do
      let(:context) { double('context', my_user: nil, my_account: nil) }

      it 'raises missing precondition error' do
        expect { subject }.to raise_error('missing precondition: my_user')
      end
    end
  end
end