-- This file was auto-generated
-- Do not edit this file as your changes may be lost!
module SemanticConvention where

import Prelude
import Data.Pair

-- | The full invoked ARN as provided on the `Context` passed to the function (`Lambda-Runtime-Invoked-Function-Arn` header on the `/runtime/invocation/next` applicable).
awsLambdaInvokedArn :: String -> Pair String
awsLambdaInvokedArn input = Pair "aws.lambda.invoked_arn" (show input)

-- | The Microsoft SQL Server [instance name](https://docs.microsoft.com/en-us/sql/connect/jdbc/building-the-connection-url?view=sql-server-ver15) connecting to. This name is used to determine the port of a named instance.
dbMssqlInstanceName :: String -> Pair String
dbMssqlInstanceName input = Pair "db.mssql.instance_name" (show input)

-- | The index of the database being accessed as used in the [`SELECT` command](https://redis.io/commands/select), provided as an integer. To be used instead of the generic `db.name` attribute.
dbRedisDatabaseIndex :: Int -> Pair String
dbRedisDatabaseIndex input = Pair "db.redis.database_index" (show input)

-- | The collection being accessed within the database stated in `db.name`.
dbMongodbCollection :: String -> Pair String
dbMongodbCollection input = Pair "db.mongodb.collection" (show input)

-- | The name of the primary table that the operation is acting upon, including the database name (if applicable).
dbSqlTable :: String -> Pair String
dbSqlTable input = Pair "db.sql.table" (show input)

-- | The type of the exception (its fully-qualified class name, if applicable). The dynamic type of the exception should be preferred over the static type in languages that support it.
exceptionType :: String -> Pair String
exceptionType input = Pair "exception.type" (show input)

-- | The exception message.
exceptionMessage :: String -> Pair String
exceptionMessage input = Pair "exception.message" (show input)

-- | A stacktrace as a string in the natural representation for the language runtime. The representation is to be determined and documented by each language SIG.
exceptionStacktrace :: String -> Pair String
exceptionStacktrace input = Pair "exception.stacktrace" (show input)

-- | SHOULD be set to true if the exception event is recorded at a point where it is known that the exception is escaping the scope of the span.
exceptionEscaped :: Boolean -> Pair String
exceptionEscaped input = Pair "exception.escaped" (show input)

-- | Type of the trigger which caused this function execution.
faasSpanTrigger :: Trigger -> Pair String
faasSpanTrigger input = Pair "faas_span.trigger" (show input)

-- | The execution ID of the current function execution.
faasSpanExecution :: String -> Pair String
faasSpanExecution input = Pair "faas_span.execution" (show input)

-- | The name of the source on which the triggering operation was performed. For example, in Cloud Storage or S3 corresponds to the bucket name, and in Cosmos DB to the database name.
faasSpanDatasourceCollection :: String -> Pair String
faasSpanDatasourceCollection input = Pair "faas_span.datasource.collection" (show input)

-- | Describes the type of the operation that was performed on the data.
faasSpanDatasourceOperation :: Operation -> Pair String
faasSpanDatasourceOperation input = Pair "faas_span.datasource.operation" (show input)

-- | A string containing the time when the data was accessed in the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format expressed in [UTC](https://www.w3.org/TR/NOTE-datetime).
faasSpanDatasourceTime :: String -> Pair String
faasSpanDatasourceTime input = Pair "faas_span.datasource.time" (show input)

-- | The document name/table subjected to the operation. For example, in Cloud Storage or S3 is the name of the file, and in Cosmos DB the table name.
faasSpanDatasourceName :: String -> Pair String
faasSpanDatasourceName input = Pair "faas_span.datasource.name" (show input)

-- | A string containing the function invocation time in the [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format expressed in [UTC](https://www.w3.org/TR/NOTE-datetime).
faasSpanTimerTime :: String -> Pair String
faasSpanTimerTime input = Pair "faas_span.timer.time" (show input)

-- | A string containing the schedule period as [Cron Expression](https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm).
faasSpanTimerCron :: String -> Pair String
faasSpanTimerCron input = Pair "faas_span.timer.cron" (show input)

-- | The name of the invoked function.
faasSpanOutInvokedName :: String -> Pair String
faasSpanOutInvokedName input = Pair "faas_span.out.invoked_name" (show input)

-- | The cloud provider of the invoked function.
faasSpanOutInvokedProvider :: InvokedProvider -> Pair String
faasSpanOutInvokedProvider input = Pair "faas_span.out.invoked_provider" (show input)

-- | The cloud region of the invoked function.
faasSpanOutInvokedRegion :: String -> Pair String
faasSpanOutInvokedRegion input = Pair "faas_span.out.invoked_region" (show input)

-- | The [`service.name`](../../resource/semantic_conventions/README.md#service) of the remote service. SHOULD be equal to the actual `service.name` resource attribute of the remote service if any.
peerService :: String -> Pair String
peerService input = Pair "peer.service" (show input)

-- | Username or client_id extracted from the access token or [Authorization](https://tools.ietf.org/html/rfc7235#section-4.2) header in the inbound request from outside the system.
identityId :: String -> Pair String
identityId input = Pair "identity.id" (show input)

-- | Actual/assumed role the client is making the request under extracted from token or application security context.
identityRole :: String -> Pair String
identityRole input = Pair "identity.role" (show input)

-- | Scopes or granted authorities the client currently possesses extracted from token or application security context. The value would come from the scope associated with an [OAuth 2.0 Access Token](https://tools.ietf.org/html/rfc6749#section-3.3) or an attribute value in a [SAML 2.0 Assertion](http://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-tech-overview-2.0.html).
identityScope :: String -> Pair String
identityScope input = Pair "identity.scope" (show input)

-- | Current "managed" thread ID (as opposed to OS thread ID).
threadId :: Int -> Pair String
threadId input = Pair "thread.id" (show input)

-- | Current thread name.
threadName :: String -> Pair String
threadName input = Pair "thread.name" (show input)

-- | The method or function name, or equivalent (usually rightmost part of the code unit's name).
codeFunction :: String -> Pair String
codeFunction input = Pair "code.function" (show input)

-- | The "namespace" within which `code.function` is defined. Usually the qualified class or module name, such that `code.namespace` + some separator + `code.function` form a unique identifier for the code unit.
codeNamespace :: String -> Pair String
codeNamespace input = Pair "code.namespace" (show input)

-- | The source code file name that identifies the code unit as uniquely as possible (preferably an absolute file path).
codeFilepath :: String -> Pair String
codeFilepath input = Pair "code.filepath" (show input)

-- | The line number in `code.filepath` best representing the operation. It SHOULD point within the code unit named in `code.function`.
codeLineno :: Int -> Pair String
codeLineno input = Pair "code.lineno" (show input)

-- | The primary server name of the matched virtual host. This should be obtained via configuration. If no such configuration can be obtained, this attribute MUST NOT be set ( `net.host.name` should be used instead).
httpServerServerName :: String -> Pair String
httpServerServerName input = Pair "http.server.server_name" (show input)

-- | The matched route (path template).
httpServerRoute :: String -> Pair String
httpServerRoute input = Pair "http.server.route" (show input)

-- | The IP address of the original client behind all proxies, if known (e.g. from [X-Forwarded-For](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For)).
httpServerClientIp :: String -> Pair String
httpServerClientIp input = Pair "http.server.client_ip" (show input)

-- | RabbitMQ message routing key.
messagingRabbitmqRoutingKey :: String -> Pair String
messagingRabbitmqRoutingKey input = Pair "messaging.rabbitmq.routing_key" (show input)

-- | Message keys in Kafka are used for grouping alike messages to ensure they're processed on the same partition. They differ from `messaging.message_id` in that they're not unique. If the key is `null`, the attribute MUST NOT be set.
messagingKafkaMessageKey :: String -> Pair String
messagingKafkaMessageKey input = Pair "messaging.kafka.message_key" (show input)

-- | Name of the Kafka Consumer Group that is handling the message. Only applies to consumers, not producers.
messagingKafkaConsumerGroup :: String -> Pair String
messagingKafkaConsumerGroup input = Pair "messaging.kafka.consumer_group" (show input)

-- | Client Id for the Consumer or Producer that is handling the message.
messagingKafkaClientId :: String -> Pair String
messagingKafkaClientId input = Pair "messaging.kafka.client_id" (show input)

-- | Partition the message is sent to.
messagingKafkaPartition :: Int -> Pair String
messagingKafkaPartition input = Pair "messaging.kafka.partition" (show input)

-- | A boolean that is true if the message is a tombstone.
messagingKafkaTombstone :: Boolean -> Pair String
messagingKafkaTombstone input = Pair "messaging.kafka.tombstone" (show input)

-- | Namespace of RocketMQ resources, resources in different namespaces are individual.
messagingRocketmqNamespace :: String -> Pair String
messagingRocketmqNamespace input = Pair "messaging.rocketmq.namespace" (show input)

-- | Name of the RocketMQ producer/consumer group that is handling the message. The client type is identified by the SpanKind.
messagingRocketmqClientGroup :: String -> Pair String
messagingRocketmqClientGroup input = Pair "messaging.rocketmq.client_group" (show input)

-- | The unique identifier for each client.
messagingRocketmqClientId :: String -> Pair String
messagingRocketmqClientId input = Pair "messaging.rocketmq.client_id" (show input)

-- | Type of message.
messagingRocketmqMessageType :: MessageType -> Pair String
messagingRocketmqMessageType input = Pair "messaging.rocketmq.message_type" (show input)

-- | The secondary classifier of message besides topic.
messagingRocketmqMessageTag :: String -> Pair String
messagingRocketmqMessageTag input = Pair "messaging.rocketmq.message_tag" (show input)

-- | Key(s) of message, another way to mark message besides message id.
messagingRocketmqMessageKeys :: (Array String) -> Pair String
messagingRocketmqMessageKeys input = Pair "messaging.rocketmq.message_keys" (show input)

-- | Model of message consumption. This only applies to consumer spans.
messagingRocketmqConsumptionModel :: ConsumptionModel -> Pair String
messagingRocketmqConsumptionModel input = Pair "messaging.rocketmq.consumption_model" (show input)

-- | The ARN of an EKS cluster.
awsEksClusterArn :: String -> Pair String
awsEksClusterArn input = Pair "aws.eks.cluster.arn" (show input)

-- | The name(s) of the AWS log group(s) an application is writing to.
awsLogGroupNames :: (Array String) -> Pair String
awsLogGroupNames input = Pair "aws.log.group.names" (show input)

-- | The Amazon Resource Name(s) (ARN) of the AWS log group(s).
awsLogGroupArns :: (Array String) -> Pair String
awsLogGroupArns input = Pair "aws.log.group.arns" (show input)

-- | The name(s) of the AWS log stream(s) an application is writing to.
awsLogStreamNames :: (Array String) -> Pair String
awsLogStreamNames input = Pair "aws.log.stream.names" (show input)

-- | The ARN(s) of the AWS log stream(s).
awsLogStreamArns :: (Array String) -> Pair String
awsLogStreamArns input = Pair "aws.log.stream.arns" (show input)

-- | Name of the cloud provider.
cloudProvider :: Provider -> Pair String
cloudProvider input = Pair "cloud.provider" (show input)

-- | The cloud account ID the resource is assigned to.
cloudAccountId :: String -> Pair String
cloudAccountId input = Pair "cloud.account.id" (show input)

-- | The geographical region the resource is running.
cloudRegion :: String -> Pair String
cloudRegion input = Pair "cloud.region" (show input)

-- | Cloud regions often have multiple, isolated locations known as zones to increase availability. Availability zone represents the zone where the resource is running.
cloudAvailabilityZone :: String -> Pair String
cloudAvailabilityZone input = Pair "cloud.availability_zone" (show input)

-- | The cloud platform in use.
cloudPlatform :: Platform -> Pair String
cloudPlatform input = Pair "cloud.platform" (show input)

-- | Container name used by container runtime.
containerName :: String -> Pair String
containerName input = Pair "container.name" (show input)

-- | Container ID. Usually a UUID, as for example used to [identify Docker containers](https://docs.docker.com/engine/reference/run/#container-identification). The UUID might be abbreviated.
containerId :: String -> Pair String
containerId input = Pair "container.id" (show input)

-- | The container runtime managing this container.
containerRuntime :: String -> Pair String
containerRuntime input = Pair "container.runtime" (show input)

-- | Name of the image the container was built on.
containerImageName :: String -> Pair String
containerImageName input = Pair "container.image.name" (show input)

-- | Container image tag.
containerImageTag :: String -> Pair String
containerImageTag input = Pair "container.image.tag" (show input)

-- | Name of the [deployment environment](https://en.wikipedia.org/wiki/Deployment_environment) (aka deployment tier).
deploymentEnvironment :: String -> Pair String
deploymentEnvironment input = Pair "deployment.environment" (show input)

-- | A unique identifier representing the device
deviceId :: String -> Pair String
deviceId input = Pair "device.id" (show input)

-- | The model identifier for the device
deviceModelIdentifier :: String -> Pair String
deviceModelIdentifier input = Pair "device.model.identifier" (show input)

-- | The marketing name for the device model
deviceModelName :: String -> Pair String
deviceModelName input = Pair "device.model.name" (show input)

-- | The name of the single function that this runtime instance executes.
faasResourceName :: String -> Pair String
faasResourceName input = Pair "faas_resource.name" (show input)

-- | The unique ID of the single function that this runtime instance executes.
faasResourceId :: String -> Pair String
faasResourceId input = Pair "faas_resource.id" (show input)

-- | The immutable version of the function being executed.
faasResourceVersion :: String -> Pair String
faasResourceVersion input = Pair "faas_resource.version" (show input)

-- | The execution environment ID as a string, that will be potentially reused for other invocations to the same function/function version.
faasResourceInstance :: String -> Pair String
faasResourceInstance input = Pair "faas_resource.instance" (show input)

-- | The amount of memory available to the serverless function in MiB.
faasResourceMaxMemory :: Int -> Pair String
faasResourceMaxMemory input = Pair "faas_resource.max_memory" (show input)

-- | Unique host ID. For Cloud, this must be the instance_id assigned by the cloud provider.
hostId :: String -> Pair String
hostId input = Pair "host.id" (show input)

-- | Name of the host. On Unix systems, it may contain what the hostname command returns, or the fully qualified hostname, or another name specified by the user.
hostName :: String -> Pair String
hostName input = Pair "host.name" (show input)

-- | Type of host. For Cloud, this must be the machine type.
hostType :: String -> Pair String
hostType input = Pair "host.type" (show input)

-- | The CPU architecture the host system is running on.
hostArch :: Arch -> Pair String
hostArch input = Pair "host.arch" (show input)

-- | Name of the VM image or OS install the host was instantiated from.
hostImageName :: String -> Pair String
hostImageName input = Pair "host.image.name" (show input)

-- | VM image ID. For Cloud, this value is from the provider.
hostImageId :: String -> Pair String
hostImageId input = Pair "host.image.id" (show input)

-- | The version string of the VM image as defined in [Version Attributes](README.md#version-attributes).
hostImageVersion :: String -> Pair String
hostImageVersion input = Pair "host.image.version" (show input)

-- | The name of the cluster.
k8SClusterName :: String -> Pair String
k8SClusterName input = Pair "k8s.cluster.name" (show input)

-- | The name of the Node.
k8SNodeName :: String -> Pair String
k8SNodeName input = Pair "k8s.node.name" (show input)

-- | The UID of the Node.
k8SNodeUid :: String -> Pair String
k8SNodeUid input = Pair "k8s.node.uid" (show input)

-- | The name of the namespace that the pod is running in.
k8SNamespaceName :: String -> Pair String
k8SNamespaceName input = Pair "k8s.namespace.name" (show input)

-- | The UID of the Pod.
k8SPodUid :: String -> Pair String
k8SPodUid input = Pair "k8s.pod.uid" (show input)

-- | The name of the Pod.
k8SPodName :: String -> Pair String
k8SPodName input = Pair "k8s.pod.name" (show input)

-- | The name of the Container from Pod specification, must be unique within a Pod. Container runtime usually uses different globally unique name (`container.name`).
k8SContainerName :: String -> Pair String
k8SContainerName input = Pair "k8s.container.name" (show input)

-- | Number of times the container was restarted. This attribute can be used to identify a particular container (running or stopped) within a container spec.
k8SContainerRestartCount :: Int -> Pair String
k8SContainerRestartCount input = Pair "k8s.container.restart_count" (show input)

-- | The UID of the ReplicaSet.
k8SReplicasetUid :: String -> Pair String
k8SReplicasetUid input = Pair "k8s.replicaset.uid" (show input)

-- | The name of the ReplicaSet.
k8SReplicasetName :: String -> Pair String
k8SReplicasetName input = Pair "k8s.replicaset.name" (show input)

-- | The UID of the Deployment.
k8SDeploymentUid :: String -> Pair String
k8SDeploymentUid input = Pair "k8s.deployment.uid" (show input)

-- | The name of the Deployment.
k8SDeploymentName :: String -> Pair String
k8SDeploymentName input = Pair "k8s.deployment.name" (show input)

-- | The UID of the StatefulSet.
k8SStatefulsetUid :: String -> Pair String
k8SStatefulsetUid input = Pair "k8s.statefulset.uid" (show input)

-- | The name of the StatefulSet.
k8SStatefulsetName :: String -> Pair String
k8SStatefulsetName input = Pair "k8s.statefulset.name" (show input)

-- | The UID of the DaemonSet.
k8SDaemonsetUid :: String -> Pair String
k8SDaemonsetUid input = Pair "k8s.daemonset.uid" (show input)

-- | The name of the DaemonSet.
k8SDaemonsetName :: String -> Pair String
k8SDaemonsetName input = Pair "k8s.daemonset.name" (show input)

-- | The UID of the Job.
k8SJobUid :: String -> Pair String
k8SJobUid input = Pair "k8s.job.uid" (show input)

-- | The name of the Job.
k8SJobName :: String -> Pair String
k8SJobName input = Pair "k8s.job.name" (show input)

-- | The UID of the CronJob.
k8SCronjobUid :: String -> Pair String
k8SCronjobUid input = Pair "k8s.cronjob.uid" (show input)

-- | The name of the CronJob.
k8SCronjobName :: String -> Pair String
k8SCronjobName input = Pair "k8s.cronjob.name" (show input)

-- | The operating system type.
osType :: Type -> Pair String
osType input = Pair "os.type" (show input)

-- | Human readable (not intended to be parsed) OS version information, like e.g. reported by `ver` or `lsb_release -a` commands.
osDescription :: String -> Pair String
osDescription input = Pair "os.description" (show input)

-- | Human readable operating system name.
osName :: String -> Pair String
osName input = Pair "os.name" (show input)

-- | The version string of the operating system as defined in [Version Attributes](../../resource/semantic_conventions/README.md#version-attributes).
osVersion :: String -> Pair String
osVersion input = Pair "os.version" (show input)

-- | Process identifier (PID).
processPid :: Int -> Pair String
processPid input = Pair "process.pid" (show input)

-- | The name of the process executable. On Linux based systems, can be set to the `Name` in `proc/[pid]/status`. On Windows, can be set to the base name of `GetProcessImageFileNameW`.
processExecutableName :: String -> Pair String
processExecutableName input = Pair "process.executable.name" (show input)

-- | The full path to the process executable. On Linux based systems, can be set to the target of `proc/[pid]/exe`. On Windows, can be set to the result of `GetProcessImageFileNameW`.
processExecutablePath :: String -> Pair String
processExecutablePath input = Pair "process.executable.path" (show input)

-- | The command used to launch the process (i.e. the command name). On Linux based systems, can be set to the zeroth string in `proc/[pid]/cmdline`. On Windows, can be set to the first parameter extracted from `GetCommandLineW`.
processCommand :: String -> Pair String
processCommand input = Pair "process.command" (show input)

-- | The full command used to launch the process as a single string representing the full command. On Windows, can be set to the result of `GetCommandLineW`. Do not set this if you have to assemble it just for monitoring; use `process.command_args` instead.
processCommandLine :: String -> Pair String
processCommandLine input = Pair "process.command_line" (show input)

-- | All the command arguments (including the command/executable itself) as received by the process. On Linux-based systems (and some other Unixoid systems supporting procfs), can be set according to the list of null-delimited strings extracted from `proc/[pid]/cmdline`. For libc-based executables, this would be the full argv vector passed to `main`.
processCommandArgs :: (Array String) -> Pair String
processCommandArgs input = Pair "process.command_args" (show input)

-- | The username of the user that owns the process.
processOwner :: String -> Pair String
processOwner input = Pair "process.owner" (show input)

-- | The name of the runtime of this process. For compiled native binaries, this SHOULD be the name of the compiler.
processRuntimeName :: String -> Pair String
processRuntimeName input = Pair "process.runtime.name" (show input)

-- | The version of the runtime of this process, as returned by the runtime without modification.
processRuntimeVersion :: String -> Pair String
processRuntimeVersion input = Pair "process.runtime.version" (show input)

-- | An additional description about the runtime of the process, for example a specific vendor customization of the runtime environment.
processRuntimeDescription :: String -> Pair String
processRuntimeDescription input = Pair "process.runtime.description" (show input)

-- | Logical name of the service.
serviceName :: String -> Pair String
serviceName input = Pair "service.name" (show input)

-- | A namespace for `service.name`.
serviceNamespace :: String -> Pair String
serviceNamespace input = Pair "service.namespace" (show input)

-- | The string ID of the service instance.
serviceInstanceId :: String -> Pair String
serviceInstanceId input = Pair "service.instance.id" (show input)

-- | The version string of the service API or implementation.
serviceVersion :: String -> Pair String
serviceVersion input = Pair "service.version" (show input)

-- | The name of the web engine.
webengineResourceName :: String -> Pair String
webengineResourceName input = Pair "webengine_resource.name" (show input)

-- | The version of the web engine.
webengineResourceVersion :: String -> Pair String
webengineResourceVersion input = Pair "webengine_resource.version" (show input)

-- | Additional description of the web engine (e.g. detailed version and edition information).
webengineResourceDescription :: String -> Pair String
webengineResourceDescription input = Pair "webengine_resource.description" (show input)

data Trigger = Datasource | Http | Other | Pubsub | Timer

data Operation = Delete | Edit | Insert | CustomOperation String

data InvokedProvider = AlibabaCloud | Aws | Azure | Gcp | TencentCloud | CustomInvokedProvider String

data MessageType = Delay | Fifo | Normal | Transaction

data ConsumptionModel = Broadcasting | Clustering

data Provider = AlibabaCloud | Aws | Azure | Gcp | TencentCloud | CustomProvider String

data Platform = AlibabaCloudEcs | AlibabaCloudFc | AwsAppRunner | AwsEc2 | AwsEcs | AwsEks | AwsElasticBeanstalk | AwsLambda | AzureAks | AzureAppService | AzureContainerInstances | AzureFunctions | AzureVm | GcpAppEngine | GcpCloudFunctions | GcpCloudRun | GcpComputeEngine | GcpKubernetesEngine | TencentCloudCvm | TencentCloudEks | TencentCloudScf | CustomPlatform String

data Arch = Amd64 | Arm32 | Arm64 | Ia64 | Ppc32 | Ppc64 | S390X | X86 | CustomArch String

data Type = Aix | Darwin | Dragonflybsd | Freebsd | Hpux | Linux | Netbsd | Openbsd | Solaris | Windows | ZOs | CustomType String


