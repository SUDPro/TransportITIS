package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.itis.entities.Trip;
import ru.itis.forms.TripForm;
import ru.itis.repository.postgres.DriverRepository;
import ru.itis.repository.postgres.TripRepository;

import java.util.List;

@Service
public class TripServiceImpl implements TripService {

    @Autowired
    TripRepository repository;

    @Autowired
    DriverRepository driverRepository;

    @Override
    public List<Trip> findAll() {
        return repository.findAll();
    }

    @Override
    public Trip findById(Long id) {
        return repository.findAllById(id).get();
    }

    @Override
    public void save(TripForm form) {
        Trip trip = Trip.builder()
                .name(form.getName())
                .start(form.getStart())
                .finish(form.getFinish())
                .driver(driverRepository.findByName(form.getDriver()).get())
                .build();
        repository.save(trip);
    }
}
