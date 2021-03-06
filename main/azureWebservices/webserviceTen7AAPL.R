# Azure Webservice Ten7AAPL

library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()


req = list(
  
  Inputs = list(
    
    
    "input1" = list(
      "ColumnNames" = list("SignalADX7", "SignalForceIndex7", "SignalROC7", "SignalStochRSI7", "SignalTRIX7", "SignalADL7", "SignalBBands7", "SignalSAR7", "SignalAROON7"),
      "Values" = list( list( processedData[1,19], processedData[1,20], processedData[1,21], processedData[1,22], processedData[1,14], processedData[1,22], processedData[1,22], processedData[1,23], processedData[1,24] ))
    )                ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "skHZWphjFLcHS4sRKyUx0Et82ujK2Fv1IQ1HFJ4R1OiS20Mvuz286TjI5v8/z5louqT1mYUaZUH4rhO2MXXA6A==" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/b3777079b3424ee2bed9f97ca8c13c5b/services/acb7e4b9c8ed4ac5b3d4f7ce8be27d80/execute?api-version=2.0&details=true",
            httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
            postfields=body,
            writefunction = h$update,
            headerfunction = hdr$update,
            verbose = TRUE
)

headers = hdr$value()
httpStatus = headers["status"]
if (httpStatus >= 400)
{
  print(paste("The request failed with status code:", httpStatus, sep=" "))
  
  # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
  print(headers)
}

result = h$value()
result = print(fromJSON(result))

Result <- result$Results$output1$value$Values[[1]][10:11]
