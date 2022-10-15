package main

import (
	"github.com/mauriciomartinezc/go_grpc/database"
	"github.com/mauriciomartinezc/go_grpc/server"
	"github.com/mauriciomartinezc/go_grpc/testpb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

const (
	UrlDatabase = "postgres://postgres:postgres@localhost:5432/postgres?sslmode=disable"
	Port        = ":5061"
)

func main() {
	listener, err := net.Listen("tcp", Port)
	if err != nil {
		log.Fatal(err)
	}
	repo, err := database.NewPostgresRepository(UrlDatabase)
	if err != nil {
		log.Fatal(err)
	}
	newServer := server.NewServerTest(repo)

	s := grpc.NewServer()

	testpb.RegisterTestServiceServer(s, newServer)

	reflection.Register(s)

	if err := s.Serve(listener); err != nil {
		log.Fatal(err)
	}
}
