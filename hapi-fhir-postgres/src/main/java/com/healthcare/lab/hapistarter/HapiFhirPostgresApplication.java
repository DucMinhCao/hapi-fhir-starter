package com.healthcare.lab.hapistarter;

import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@EntityScan(basePackageClasses = PatientEntity.class)
@ServletComponentScan
public class HapiFhirPostgresApplication {

  public static void main(String[] args) {
    SpringApplication.run(HapiFhirPostgresApplication.class, args);
  }
}
