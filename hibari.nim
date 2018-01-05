import jester
import asyncdispatch
import jsmn
# import sam
import msgpack4nim
import httpclient

proc kitsuGet(url: string): string =
  let client = newHttpClient()
  const JsonApi = "application/vnd.api+json"
  client.headers = newHttpHeaders({
    "Content-Type": JsonApi,
    "Accept": JsonApi
  })
  let response = client.request(url, httpMethod = HttpGet)
  return response.body

routes:
  get "/":
    headers["Cache-Control"] = "max-age=60, public"
    headers["Connection"] = "close"
    let externalRequest = kitsuGet("https://kitsu.io/api/edge/anime")
    resp(pack(externalRequest), contentType = "application/msgpack")

runForever()

#[
routes:
  get "/":
    headers["Cache-Control"] = "max-age=60, public"
    headers["Connection"] = "close"
    let json_response = %* { "secure": request.secure }
    resp(pack($json_response), contentType = "application/json")
    # resp h1("Hello world")

  get "/400":
    halt Http400, "This is a 400 error"

runForever()
]#

