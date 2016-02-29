RSpec.describe FormattedDateHelper do
  specify { expect(formatted_date('1/1/2014')).to eql '2014-01-01' }
  specify { expect(formatted_date(nil)).to be nil }
  specify { expect(formatted_timestamp('1/1/2014')).to eql '2014-01-01 00:00:00 UTC' }
  specify { expect(formatted_timestamp(nil)).to be nil }
  specify { expect(formatted_timestamp('2015-03-06 10:30')).to eql '2015-03-06 10:30:00 UTC' }
end
