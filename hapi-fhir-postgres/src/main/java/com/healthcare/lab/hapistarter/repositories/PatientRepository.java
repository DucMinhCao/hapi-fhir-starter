package com.healthcare.lab.hapistarter.repositories;

import com.healthcare.lab.hapistarter.domain.entities.PatientEntity;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.jetbrains.annotations.NotNull;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends CrudRepository<PatientEntity, Long> {

  @NotNull Optional<PatientEntity> findById(@NotNull Long id);

  List<PatientEntity> findByDateOfBirth(Date dob);

  @Query(value = "SELECT p FROM PatientEntity p JOIN Name n ON p.id = n.patientEntity.id WHERE n.familyName = ?1")
  List<PatientEntity> findByFamilyName(String familyName);

  @Query(value = "SELECT p FROM PatientEntity p JOIN Name n ON p.id = n.patientEntity.id WHERE n.givenName = ?1")
  List<PatientEntity> findByGivenName(String givenName);
}
