package com.healthcare.lab.hapistarter.domain.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hl7.fhir.r4.model.Enumerations;

import javax.persistence.*;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "patient")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PatientEntity {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  @Basic(optional = false)
  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = "created_time", updatable = false)
  private Date createdTime;

  @Basic(optional = false)
  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = "updated_time")
  private Date updatedTime;

  private Date dateOfBirth;

  private Enumerations.AdministrativeGender gender;

  @OneToMany(fetch = FetchType.EAGER, mappedBy = "patientEntity", cascade = CascadeType.ALL)
  private Set<Name> names = new LinkedHashSet<>();

  @OneToMany(fetch = FetchType.EAGER, mappedBy = "patientEntity", cascade = CascadeType.ALL)
  private Set<Identifier> identifiers = new LinkedHashSet<>();

  @OneToMany(fetch = FetchType.EAGER, mappedBy = "patientEntity", cascade = CascadeType.ALL)
  private Set<Address> addresses = new LinkedHashSet<>();

  @OneToMany(fetch = FetchType.EAGER, mappedBy = "patientEntity", cascade = CascadeType.ALL)
  private Set<Telecom> telecoms = new LinkedHashSet<>();

  @PrePersist
  public void onPrePersist() {
    Date now = new Date();
    createdTime = now;
    updatedTime = now;
  }

  @PreUpdate
  public void onPreUpdate() {
    updatedTime = new Date();
  }

  public void addToName(Name name) {
    name.setPatientEntity(this);
    this.names.add(name);
  }

  public void addToAddress(Address address) {
    address.setPatientEntity(this);
    this.addresses.add(address);
  }

  public void addToTelecom(Telecom telecom) {
    telecom.setPatientEntity(this);
    this.telecoms.add(telecom);
  }

  public void addToIdentifer(Identifier identifier) {
    identifier.setPatientEntity(this);
    this.identifiers.add(identifier);
  }
}
