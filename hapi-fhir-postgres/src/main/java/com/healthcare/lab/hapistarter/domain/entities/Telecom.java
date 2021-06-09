package com.healthcare.lab.hapistarter.domain.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hl7.fhir.r4.model.ContactPoint.ContactPointSystem;
import org.hl7.fhir.r4.model.ContactPoint.ContactPointUse;

import javax.persistence.*;

@Entity
@Table(name = "telecom")
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Telecom {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;
  private String value;
  private ContactPointSystem system;
  private ContactPointUse use;

  @ManyToOne(fetch = FetchType.LAZY)
  private PatientEntity patientEntity;

}
