require 'helper'
require 'aws_iam_policy'

class AwsIamPolicyTest < Minitest::Test
	Arn = 'testarn'.freeze
	Policy = 'policytest'.freeze

	def setup
		@mock_conn = Minitest::Mock.new
		@mock_resource = Minitest::Mock.new
		@mock_policy = Minitest::Mock.new
		@mock_conn.expect :iam_resource, @mock_resource
		@mock_resource.expect :policy, @mock_policy, [Arn]
	end
	
	def test_policy_exists_when_policy_exists
		@mock_policy.expect :nil?, false
		assert AwsIamPolicy.new(Arn,@mock_conn).exists?
	end

	def test_policy_does_not_exist_when_no_policy_exists
		@mock_policy.expect :nil?, true
		refute AwsIamPolicy.new(Arn,@mock_conn).exists?
	end

	def test_name_returns_policy_name
		@mock_policy.expect :nil?, false
		@mock_policy.expect :policy_name, Policy
		assert_equal Policy, AwsIamPolicy.new(Arn,@mock_conn).name
	end
end