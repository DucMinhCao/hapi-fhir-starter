package com.healthcare.lab.hapistarter;

import com.healthcare.lab.hapistarter.domain.entities.Address;
import com.healthcare.lab.hapistarter.domain.entities.Name;
import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import com.healthcare.lab.hapistarter.domain.entities.Telecom;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class HapiFhirPostgresApplicationTests {

  @Test
  void contextLoads() {
  }

  @Test
  @DisplayName("Shoud be create Address")
  public void testAddress() {
    Address address = new Address();
    address.setCity("HCM");
    address.setCountry("Vn");
    address.setPostalCode("51");
    Assertions.assertEquals("HCM", address.getCity());
    Assertions.assertEquals("Vn", address.getCountry());
    Assertions.assertEquals("51", address.getPostalCode());
  }

  @Test
  @DisplayName("Shoud be create Name")
  public void testName() {
    Name name = new Name();
    name.setFamilyName("Austin");
    name.setGivenName("Post");
    Assertions.assertNotNull(name.getGivenName());
    Assertions.assertNotNull(name.getUse());
  }

  @Test
  @DisplayName("Name should not contain special character")
  public void testSpecialCharacter() {
    Name name = new Name();
    name.setUse("Official");
    name.setGivenName("\\\\johndoe$");
    Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
    Matcher m = p.matcher(name.getGivenName());
    Assertions.assertFalse(m.find());
  }

  @Test
  @DisplayName("Telecom should contain with number")
  public void testTelecom() {
    Telecom telecom = new Telecom();
    telecom.setValue("+(123) - 456-78-90");
    Pattern p = Pattern
        .compile("^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s\\./0-9]*$", Pattern.CASE_INSENSITIVE);
    Matcher m = p.matcher(telecom.getValue());
    Assertions.assertTrue(m.find());
  }

  @Test
  @DisplayName("Patient Entity shoule be created")
  public void testPatientEntity() {
    PatientEntity patientEntity = new PatientEntity();

    Telecom telecom = new Telecom();
    telecom.setValue("+(123) - 456-78-90");

    Name name = new Name();
    name.setFamilyName("Austin");
    name.setGivenName("Post");

    Address address = new Address();
    address.setCity("HCM");
    address.setCountry("Vn");
    address.setPostalCode("51");

    patientEntity.getNames().add(name);
    patientEntity.getTelecoms().add(telecom);
    patientEntity.getAddresses().add(address);

    Assertions.assertFalse(patientEntity.getAddresses().isEmpty());
    Assertions.assertFalse(patientEntity.getTelecoms().isEmpty());
    Assertions.assertFalse(patientEntity.getNames().isEmpty());

    Assertions.assertEquals(1, patientEntity.getAddresses().size());
    Assertions.assertEquals(1, patientEntity.getTelecoms().size());
    Assertions.assertEquals(1, patientEntity.getNames().size());
  }


}
