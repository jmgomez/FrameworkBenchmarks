import chronos
import kairos

const
  PlainHeader = "Content-Type: text/plain"
  JsonHeader = "Content-Type: application/json"
  HelloJson = """{"message":"Hello, World!"}"""

proc onRequest(req: Request): Future[void] {.gcsafe, async.} =
  let p = req.path.get("/")
  if p == "/plaintext":
    req.send(Http200, "Hello, World!", PlainHeader)
  elif p == "/json":
    req.send(Http200, HelloJson, JsonHeader)
  else:
    req.send(Http404)

run(onRequest, initSettings(port = Port(8080), numThreads = 0))
