aws cloudwatch get-metric-data --start-time $(date -v -50H +%s) --end-time $(date -v -45H +%s) --metric-data-queries '[
    
    {
      "Id": "m1",
      "MetricStat": {
        "Metric": {
          "MetricName": "CPUUtilization",
          "Namespace": "AWS/ECS",
          "Dimensions": [
            {
              "Name": "ServiceName",
              "Value": "my-service-name"
            },
            {
                "Name": "ClusterName",
                "Value": "my-cluster-name"
            }
          ]
        },
        "Period": 300,
        "Stat": "Average"
      }
    }
  ]' --output json | jq -r '.MetricDataResults[].Values[]' | asciigraph -h 20 -c "super readable chart"