# Deploy a Kafka on HDInsight cluster with the Schema Registry

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fvcivelek%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## About
This template allows you to create a Kafka cluster on a HDInsight cluster.   
It also installs an edge node and installs the Schema Registry on an edge node.   
For more on Azure HDInsight templates, you can visit:   
https://docs.microsoft.com/en-us/azure/templates/microsoft.hdinsight/allversions 

## Post Deploy Items
 - If you can't login with the setup credentials, you can re-setup like below:  
   - From the cluster home page, select Script actions under Settings.  
   - From the Script Actions blade, select Submit New.  
   - With the below settings, hit create and let it complete.  
   
|  |  |  
|---|---|
| Script Type | Custom  | 
| Name | Change ssh password |
| URI | https://raw.githubusercontent.com/vcivelek/hdinsight-kafka-with-schema-registry/master/scripts/login.sh  |
| Node Types | Select All | 
| Parameters | username password (i.e. kafka Kafka12345!) | 
| Persist? | Unchecked |  

 - SSH into the edge node. 
 - We need to edit the `schema-registry.properties` file.  
 For this we need `Zookeeper hosts` information.
 
 - For `Zookeper hosts` run:  
 
        curl -u username:password -G "https://CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/CLUSTER_NAME/services/ZOOKEEPER/components/ZOOKEEPER_SERVER" | jq -r '["\(.host_components[].HostRoles.host_name):2181"] | join(",")'
   - You can obtain the same information from the Ambari Web UI as well.
 - On the edge node (schema registry) edit the `schema-registry.properties` under `/etc/schema-registry/`
 - Start the schema registry `schema-registry-start schema-registry.properties` (consider running this with nohup)
 - You have running Schema Registry attached to your Kafka cluster. 
 - Below link lists some REST calls to the schema registry.  
 https://github.com/confluentinc/schema-registry#quickstart


