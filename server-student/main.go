package main

import (
	"github.com/mauriciomartinezc/go_grpc/database"
	"github.com/mauriciomartinezc/go_grpc/server"
	"github.com/mauriciomartinezc/go_grpc/studentpb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

const (
	UrlDatabase = "postgres://postgres:postgres@localhost:5432/postgres?sslmode=disable"
	Port        = ":5060"
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
	newServer := server.NewServerStudent(repo)

	s := grpc.NewServer()

	studentpb.RegisterStudentServiceServer(s, newServer)

	reflection.Register(s)

	if err := s.Serve(listener); err != nil {
		log.Fatal(err)
	}
}
