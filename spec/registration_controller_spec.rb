require_relative '../controllers/registration'
RSpec.describe 'validate' do
  # Constructs mock input data hash
  def input_hash(email, pass, re_pass, user_type)
    { 'email' => email, 'pass' => pass, 're-pass' => re_pass, 'user-type' => user_type }
  end
  context 'when all input is valid' do
    it 'returns a hash without errors' do
      expect(validate(input_hash('legit@email.com', 'SecurePass123', 'SecurePass123', '1')))
        .to eq({ 'valid' => true, 'errors' => {} })
    end
  end
  context 'when all input is empty' do
    it 'returns a hash indicating the first empty field' do
      expect(validate(input_hash(nil, nil, nil, nil)))
        .to eq({ 'valid' => false, 'errors' => { 'email' => 'Please enter your email' } })
    end
  end
  context 'when one field is empty' do
    it 'returns a hash indicating the empty field' do
      expect(validate(input_hash('legit@email.com', 'SecurePass123', nil, '1')))
        .to eq({ 'valid' => false, 'errors' => { 're-pass' => 'Please retype your password' } })
    end
  end
  context 'when given email is invalid' do
    it {
      expect(validate(input_hash('invalid$$$email...lulz', nil, nil, nil))['errors']['email'])
        .to eq('Invalid email')
    }
  end
  context 'when given password is invalid' do
    it {
      expect(validate(input_hash('legit@email.com', 'weak', nil, nil))['errors']['pass'])
        .to eq('Must be at least 8 characters long and contain a lowercase, uppercase letter and a number')
    }
  end
  context 'when passwords do not match' do
    it {
      expect(validate(input_hash('legit@email.com', 'SecurePass123', 'SecurePas123', '1'))['errors']['re-pass'])
        .to eq('Passwords do not match')
    }
  end
end
