package com.healthcare.lab.hapistarter.providers;

import ca.uhn.fhir.rest.annotation.Create;
import ca.uhn.fhir.rest.annotation.ResourceParam;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.server.IResourceProvider;
import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import com.healthcare.lab.hapistarter.domain.transform.FHIRPatientToPatientEntity;
import com.healthcare.lab.hapistarter.repositories.PatientRepository;
import javax.servlet.http.HttpServletRequest;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BundleResourceProvider implements IResourceProvider {

  @Autowired
  private PatientRepository patientRepository;

  @Autowired
  private FHIRPatientToPatientEntity fhirPatientToPatientEntity;

  @Override
  public Class<Bundle> getResourceType() {
    return Bundle.class;
  }

  @Create()
  public MethodOutcome create(HttpServletRequest theRequest, @ResourceParam Bundle bundle) {

    MethodOutcome method = new MethodOutcome();
    method.setCreated(true);
    OperationOutcome opOutcome = new OperationOutcome();

    for (Bundle.BundleEntryComponent entry : bundle.getEntry()) {
      if (entry.getResource() instanceof Patient) {
        try {
          PatientEntity myPatient = patientRepository.save(fhirPatientToPatientEntity
              .transform((Patient) entry.getResource()));
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    }

    method.setOperationOutcome(opOutcome);
    return method;
  }
}
