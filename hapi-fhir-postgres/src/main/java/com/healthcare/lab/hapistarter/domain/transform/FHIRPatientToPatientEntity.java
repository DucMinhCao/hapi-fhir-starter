package com.healthcare.lab.hapistarter.domain.transform;

import com.healthcare.lab.hapistarter.domain.entities.Name;
import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import com.healthcare.lab.hapistarter.domain.entities.Telecom;
import org.apache.commons.collections4.Transformer;
import org.hl7.fhir.r4.model.Address;
import org.hl7.fhir.r4.model.ContactPoint;
import org.hl7.fhir.r4.model.HumanName;
import org.hl7.fhir.r4.model.Identifier;
import org.hl7.fhir.r4.model.Patient;
import org.springframework.stereotype.Component;

@Component
public class FHIRPatientToPatientEntity implements Transformer<Patient, PatientEntity> {

  @Override
  public PatientEntity transform(Patient patient) {
    final PatientEntity patientEntity = new PatientEntity();

    for (Identifier identifier : patient.getIdentifier()) {
      com.healthcare.lab.hapistarter.domain.entities.Identifier identifierE =
          new com.healthcare.lab.hapistarter.domain.entities.Identifier();
      identifierE.setSystem(identifier.getSystem());
      identifierE.setValue(identifier.getValue().replaceAll(" ", ""));

      patientEntity.getIdentifiers().add(identifierE);
      patientEntity.addToIdentifer(identifierE);
    }
    for (HumanName name : patient.getName()) {
      Name nameE = new Name();
      nameE.setFamilyName(name.getFamily());
      nameE.setGivenName(name.getGivenAsSingleString());
      if (name.hasPrefix()) {
        nameE.setPrefix(name.getPrefix().get(0).getValue());
      }
      nameE.setUse(name.getUse().toString());

      patientEntity.getNames().add(nameE);
      patientEntity.addToName(nameE);
    }
    if (patient.hasBirthDate()) {
      patientEntity.setDateOfBirth(patient.getBirthDate());
    }
    if (patient.hasGender()) {
      patientEntity.setGender(patient.getGender());
    }
    for (ContactPoint contactPoint : patient.getTelecom()) {
      Telecom telecom = new Telecom();
      telecom.setValue(contactPoint.getValue());
      if (contactPoint.hasSystem()) {
        telecom.setSystem(contactPoint.getSystem());
      }
      if (contactPoint.hasUse()) {
        telecom.setUse(contactPoint.getUse());
      }

      patientEntity.getTelecoms().add(telecom);
      patientEntity.addToTelecom(telecom);
    }
    for (Address address : patient.getAddress()) {
      com.healthcare.lab.hapistarter.domain.entities.Address addressEntity =
          new com.healthcare.lab.hapistarter.domain.entities.Address();

      addressEntity.setLine(address.getLine().toString());

      if (address.hasCity()) {
        addressEntity.setCity(address.getCity());
      }
      if (address.hasPostalCode()) {
        addressEntity.setPostalCode(address.getPostalCode());
      }
      if (address.hasCountry()) {
        addressEntity.setCountry(address.getCountry());
      }
      if (address.hasState()) {
        addressEntity.setState(address.getState());
      }

      patientEntity.getAddresses().add(addressEntity);
      patientEntity.addToAddress(addressEntity);
    }
    return patientEntity;
  }
}
