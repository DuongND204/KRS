package models.dao;

import models.DAO;
import models.Lesson;

import java.util.List;

public class LessonDAO implements DAO<Lesson> {

    @Override
    public void create(Lesson lesson) {

    }

    @Override
    public void update(Lesson lesson) {

    }

    @Override
    public void delete(Lesson lesson) {

    }

    @Override
    public Lesson findById(int id) {
        return null;
    }

    @Override
    public List<Lesson> findAll() {
        return List.of();
    }
}
