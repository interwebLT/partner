RSpec.shared_examples_for 'a required field' do |field|
  context 'when nil' do
    let(field)  { nil }

    it { is_expected.to be_invalid }
  end

  context 'when blank' do
    let(field)  { '' }

    it { is_expected.to be_invalid }
  end
end

RSpec.shared_examples_for 'a string field' do |field|
  context 'when too long' do
    let(field) { '123456789 223456789 323456789 423456789 523456789 623456789 723456789 823456789 923456789 A23456789 X' }

    it { is_expected.to be_invalid }
  end
end

RSpec.shared_examples_for 'an address field' do |field|
  context 'when too long' do
    let(field)  { '123456789 223456789 323456789 423456789 523456789 X' }

    it { is_expected.to be_invalid }
  end
end

RSpec.shared_examples_for 'a contact number field' do |field|
  context 'when too short' do
    let(field) { '+63.567' }

    it { is_expected.to be_invalid }
  end

  context 'when too long' do
    let(field) { '+63.56789022345678903234567890420' }

    it { is_expected.to be_invalid }
  end

  context 'when not in format' do
    let(field) { '123456789 ' }

    it { is_expected.to be_invalid }
  end
end
