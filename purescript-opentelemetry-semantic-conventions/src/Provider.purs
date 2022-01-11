module OpenTelemetry.SemanticConvention.Provider where

import Prelude

data Provider = AlibabaCloud | Aws | Azure | Gcp | TencentCloud | CustomProvider String

instance Show Provider where
  show AlibabaCloud = "alibaba_cloud"
  show Aws = "aws"
  show Azure = "azure"
  show Gcp = "gcp"
  show TencentCloud = "tencent_cloud"
  show (CustomProvider value) = value