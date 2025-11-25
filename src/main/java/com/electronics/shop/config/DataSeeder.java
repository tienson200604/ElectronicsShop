package com.electronics.shop.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataSeeder implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        // Data seeding disabled as we are using existing database
    }
}
