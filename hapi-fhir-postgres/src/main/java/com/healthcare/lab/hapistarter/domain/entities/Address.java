package com.healthcare.lab.hapistarter.domain.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "address")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Address {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;
  private String city;
  private String country;
  private String state;
  private String line;
  private String postalCode;

  @ManyToOne(fetch = FetchType.LAZY)
  private PatientEntity patientEntity;

}
