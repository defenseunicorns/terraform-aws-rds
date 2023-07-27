package e2e_test

import (
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	teststructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
	"time"
)

func TestExamplesComplete(t *testing.T) {
	var approvedRegions = []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}
	awsRegion := "us-west-1" //aws.GetRandomStableRegion(t, approvedRegions, nil)
	backupAwsRegion := aws.GetRandomStableRegion(t, approvedRegions, []string{awsRegion})

	t.Parallel()
	tempFolder := teststructure.CopyTerraformFolderToTemp(t, "..", "examples/complete")
	terraformOptions := &terraform.Options{
		TerraformDir: tempFolder,
		Upgrade:      false,
		RetryableTerraformErrors: map[string]string{
			".*empty output.*": "bug in aws_s3_bucket_logging, intermittent error",
		},
		MaxRetries:         5,
		TimeBetweenRetries: 5 * time.Second,
		Vars: map[string]interface{}{
			"name_prefix":                "ci",
			"region":                     awsRegion,
			"region2":                    backupAwsRegion,
			"rds_create_random_password": false,
			"rds_password":               "my-password",
			"tags": map[string]string{
				"ManagedBy": "Terraform",
				"Repo":      "https://github.com/defenseunicorns/terraform-aws-uds-rds",
			},
		},
	}

	// Defer the teardown
	defer func() {
		t.Helper()
		teststructure.RunTestStage(t, "TEARDOWN", func() {
			terraform.Destroy(t, terraformOptions)
		})
	}()

	// Set up the infra
	teststructure.RunTestStage(t, "SETUP", func() {
		terraform.InitAndApply(t, terraformOptions)
	})

	// Run assertions
	teststructure.RunTestStage(t, "TEST", func() {
		// Assertions go here
	})
}
