package com.mgieroba.flycierge;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class Server {

	public static void main(String[] args) {
		SpringApplication.run(Server.class, args);
	}
}
