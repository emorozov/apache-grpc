import grpc
from django.http import HttpResponse

from hello.hello_pb2 import HelloRequest
from hello.hello_pb2_grpc import GreeterStub


def ping(request):
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = GreeterStub(channel)
        response = stub.SayHello(HelloRequest(name='you'))
    return HttpResponse(f'Greeter client received: {response.message}')

