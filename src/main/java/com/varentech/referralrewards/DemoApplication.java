package com.varentech.referralrewards;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@PropertySource("classpath:application.properties")
public class DemoApplication {



	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
}