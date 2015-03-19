require 'test_helper'

describe FormattedDateHelper do
  specify { formatted_date('1/1/2014').must_equal '2014-01-01' }
  specify { formatted_date(nil).must_be_nil }
  specify { formatted_timestamp('1/1/2014').must_equal '2014-01-01 00:00:00 UTC' }
  specify { formatted_timestamp(nil).must_be_nil }
  specify { formatted_timestamp('2015-03-06 10:30').must_equal '2015-03-06 10:30:00 UTC' }
end
