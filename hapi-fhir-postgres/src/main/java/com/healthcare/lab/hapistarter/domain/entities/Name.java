package com.healthcare.lab.hapistarter.domain.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "name")
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Name {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;
  private String familyName;
  private String givenName;
  private String prefix;
  private String use;

  @ManyToOne(fetch = FetchType.LAZY)
  private PatientEntity patientEntity;

}