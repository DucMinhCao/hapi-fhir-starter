package com.healthcare.lab.hapistarter;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.param.StringParam;
import com.healthcare.lab.hapistarter.domain.entities.Name;
import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import com.healthcare.lab.hapistarter.domain.transform.FHIRPatientToPatientEntity;
import com.healthcare.lab.hapistarter.domain.transform.PatientEntityToFHIRPatient;
import com.healthcare.lab.hapistarter.providers.PatientResourceProvider;
import com.healthcare.lab.hapistarter.repositories.PatientRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Resource;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class PatientProviderTest {

  @Mock
  private static PatientRepository patientRepository;

  @Mock
  private PatientEntityToFHIRPatient patientEntityToFHIRPatient;

  @Mock
  private FHIRPatientToPatientEntity fhirPatientToPatientEntity;

  @Test
  @DisplayName("Test Search Patient By Given Name")
  public void searchByGivenName() {
    PatientResourceProvider patientResourceProvider =
        new PatientResourceProvider(patientRepository, patientEntityToFHIRPatient,
            fhirPatientToPatientEntity);
    PatientEntity patientEntity = new PatientEntity();
    Name name = new Name();
    name.setGivenName("John");
    patientEntity.getNames().add(name);

    List<PatientEntity> expected = new ArrayList<>();
    expected.add(patientEntity);

    Mockito.when(patientRepository.findByGivenName("John")).thenReturn(expected);

    List<Resource> actual = patientResourceProvider.searchByGivenName(new StringParam("John"));

    Mockito.when(fhirPatientToPatientEntity.transform((Patient) actual.get(0)))
        .thenReturn(patientEntity);

    Assertions.assertEquals(fhirPatientToPatientEntity.transform((Patient) actual.get(0)),
        expected.get(0));
  }

  @Test
  @DisplayName("Test Get Patient By Id")
  public void getPatientById() {
    PatientResourceProvider patientResourceProvider =
        new PatientResourceProvider(patientRepository, patientEntityToFHIRPatient,
            fhirPatientToPatientEntity);

    Patient expected = new Patient();
    expected.setId(new IdType(1L));

    PatientEntity patientEntity = new PatientEntity();
    patientEntity.setId(1L);
    Name name = new Name();
    name.setGivenName("John");
    patientEntity.getNames().add(name);

    Mockito.when(patientRepository.findById(1L)).thenReturn(Optional.of(patientEntity));
    Mockito.when(patientEntityToFHIRPatient.transform(patientEntity)).thenReturn(expected);

    Patient actualPatient = patientResourceProvider.getPatientById(new IdType(1L));
    Assertions.assertEquals(actualPatient.getId(), expected.getId());
  }

  @Test
  @DisplayName("Test Create Patient")
  public void createPatient() {
    PatientResourceProvider patientResourceProvider =
        new PatientResourceProvider(patientRepository, patientEntityToFHIRPatient,
            fhirPatientToPatientEntity);

    Patient fhirPatient = new Patient();
    fhirPatient.setId(new IdType(1L));

    PatientEntity patientEntity = new PatientEntity();
    patientEntity.setId(1L);

    Mockito.when(fhirPatientToPatientEntity.transform(fhirPatient)).thenReturn(patientEntity);
    Mockito.when(patientRepository.save(patientEntity)).thenReturn(patientEntity);

    MethodOutcome actual = patientResourceProvider.createPatient(fhirPatient);

    Assertions.assertEquals(Long.valueOf(fhirPatient.getId()), patientEntity.getId());
  }
}
