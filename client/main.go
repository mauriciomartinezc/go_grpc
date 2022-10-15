package main

import (
	"context"
	"github.com/mauriciomartinezc/go_grpc/testpb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"log"
)

func main() {
	cc, err := grpc.Dial("localhost:5061", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("could not connect: %v", err)
	}
	defer cc.Close()
	c := testpb.NewTestServiceClient(cc)
	DoUnary(c)
}

func DoUnary(c testpb.TestServiceClient) {
	req := &testpb.GetTestRequest{Id: "1"}
	res, err := c.GetTest(context.Background(), req)
	if err != nil {
		log.Fatalf("error while calling GetTest: %v", err)
	}
	log.Printf("response form server: %v", res)
}
