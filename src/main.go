package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	tele "gopkg.in/telebot.v3"
)

var rootCmd = &cobra.Command{
	Use:   "go-bot",
	Short: "Go-bot",
	Long:  "Go-booooooooooooooot",
	Run: func(cmd *cobra.Command, args []string) {
		token := os.Getenv("TELE_TOKEN")
		if token == "" {
			fmt.Println("TELE_TOKEN environment variable is not set.")
			return
		}
	},
}

func main() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	pref := tele.Settings{
		Token:  os.Getenv("TELE_TOKEN"),
		Poller: &tele.LongPoller{Timeout: 10 * time.Second},
	}

	b, err := tele.NewBot(pref)
	if err != nil {
		log.Fatal(err)
		return
	}

	b.Handle("/hello", func(c tele.Context) error {
		return c.Send("Hello!")
	})

	b.Handle("/timenow", func(c tele.Context) error {
		now := time.Now()
		unixTime := now.Unix()

		return c.Send(fmt.Sprintf("%d", unixTime))
	})

	b.Start()
}
