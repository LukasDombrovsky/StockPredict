# Azure Webservice Ten14INTC

library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()


req = list(
  
  Inputs = list(
    
    
    "input1" = list(
      "ColumnNames" = list("SignalADX14", "SignalForceIndex14", "SignalROC14", "SignalStochRSI14", "SignalTRIX14", "SignalADL14", "SignalBBands14", "SignalSAR14", "SignalAROON14"),
      "Values" = list( list( processedData[1,28], processedData[1,29], processedData[1,30], processedData[1,31], processedData[1,32], processedData[1,33], processedData[1,34], processedData[1,35], processedData[1,36] ))
    )                ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "982z3Kh1Nk+qMTNikfLYZMZ42ZIw7MK9FNrVRaZbHjgpIqacH/RWGeqX66pEgHc0+y0nWGuoeLU5+AerZ6x0ZQ==" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/b3777079b3424ee2bed9f97ca8c13c5b/services/91a1ca1763a644198b764ab58d225468/execute?api-version=2.0&details=true",
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
