# Read Me First
The following was discovered as part of building this project:

* The original package name 'com.heathcare.lab.hapi-starter' is invalid and this project uses 'com.heathcare.lab.hapistarter' instead.

Modules: 
- **hapi-fhir-open-emr**: Demo HAPI FHIR integrate with OpenEMR (Patient, Appointment ). [Demo & Guideline](https://github.com/kms-healthcare/hapi-fhir-starter/wiki/HAPI-FHIR---OpenEMR)
- **hapi-fhir-postgres**: Demo HAPI FHIR integrate with Self Managed Postgres. [Demo & Guideline](https://github.com/kms-healthcare/hapi-fhir-starter/wiki/HAPI-FHIR-POSTGRES)
- **tools-gen-openemr-data**: A tool with the aim of generating samples data for OpenEMR
- **tools-gen-postgres**: A tool with the aim of generating samples data for Postgres
- **devops**: Contains Helm Charts, Infrastructure As Code (Terraform)
# Getting Started

* Configure database in application.yaml
* Run command `./mvnw clean spring-boot:run` to start

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.4.5/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.4.5/maven-plugin/reference/html/#build-image)
* [Spring Boot DevTools](https://docs.spring.io/spring-boot/docs/2.4.5/reference/htmlsingle/#using-boot-devtools)
* [Spring Configuration Processor](https://docs.spring.io/spring-boot/docs/2.4.5/reference/htmlsingle/#configuration-metadata-annotation-processor)
* [Jersey](https://docs.spring.io/spring-boot/docs/2.4.5/reference/htmlsingle/#boot-features-jersey)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.4.5/reference/htmlsingle/#boot-features-jpa-and-spring-data)
* [Flyway Migration](https://docs.spring.io/spring-boot/docs/2.4.5/reference/htmlsingle/#howto-execute-flyway-database-migrations-on-startup)

### Guides
The following guides illustrate how to use some features concretely:

* [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)

Hehehehe