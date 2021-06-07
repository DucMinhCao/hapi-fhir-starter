package com.healthcare.lab.hapistarter.domain.transform;

import com.healthcare.lab.hapistarter.domain.entities.Address;
import com.healthcare.lab.hapistarter.domain.entities.Identifier;
import com.healthcare.lab.hapistarter.domain.entities.Name;
import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import com.healthcare.lab.hapistarter.domain.entities.Telecom;
import org.apache.commons.collections4.Transformer;
import org.hl7.fhir.r4.model.ContactPoint;
import org.hl7.fhir.r4.model.HumanName;
import org.hl7.fhir.r4.model.Patient;
import org.springframework.stereotype.Component;

@Component
public class PatientEntityToFHIRPatient implements Transformer<PatientEntity, Patient> {

  @Override
  public Patient transform(PatientEntity patientEntity) {
    final Patient patient = new Patient();

    patient.setId(patientEntity.getId().toString());

    for (Identifier identifier : patientEntity.getIdentifiers()) {
      patient.addIdentifier()
          .setSystem(identifier.getSystem())
          .setValue(identifier.getValue());
    }

    for (Name name : patientEntity.getNames()) {
      HumanName humanName = patient.addName();

      humanName.setFamily(name.getFamilyName())
          .addGiven(name.getGivenName());
    }

    if (patientEntity.getDateOfBirth() != null) {
      patient.setBirthDate(patientEntity.getDateOfBirth());
    }

    if (patientEntity.getGender() != null) {
      patient.setGender(patientEntity.getGender());
    }

    for (Telecom telecom : patientEntity.getTelecoms()) {
      ContactPoint contactPoint = new ContactPoint();
      contactPoint.setValue(telecom.getValue());
        if (telecom.getSystem() != null) {
            contactPoint.setSystem(telecom.getSystem());
        }
      if (telecom.getUse() != null) {
        contactPoint.setUse(telecom.getUse());
      }
      patient.getTelecom().add(contactPoint);
    }

    for (Address addressEntity : patientEntity.getAddresses()) {
      org.hl7.fhir.r4.model.Address address = new org.hl7.fhir.r4.model.Address();
      patient.getAddress().add(address);
      address.addLine(addressEntity.getLine());
        if (addressEntity.getCity() != null) {
            address.setCity(addressEntity.getCity());
        }
        if (addressEntity.getPostalCode() != null) {
            address.setPostalCode(addressEntity.getPostalCode());
        }
        if (addressEntity.getCountry() != null) {
            address.setCountry(addressEntity.getCountry());
        }
        if (addressEntity.getState() != null) {
            address.setState(addressEntity.getState());
        }
    }
    return patient;
  }
}
