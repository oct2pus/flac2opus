package main

import (
	"fmt"
	"io/fs"
	"log"
	"os"
	"strings"
)

func main() {
	var files []fs.DirEntry
	var err error
	if len(os.Args) > 1 {
		files, err = os.ReadDir(os.Args[1])
	} else {
		files, err = os.ReadDir(".")
	}
	if err != nil {
		log.Fatalln(err)
	}
	for _, file := range files {
		if !file.IsDir() && !strings.HasPrefix(file.Name(), ".") {
			fmt.Println(file.Name())
		}
	}
}
