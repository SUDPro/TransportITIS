package ru.itis.aspects;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import ru.itis.entities.Log;
import ru.itis.repository.mongodb.LogsRepository;

import java.util.Arrays;
import java.util.Date;

@Aspect
@Configuration
public class MyLogger {

    private Logger logger;

    @Autowired
    private LogsRepository logsRepository;

    public MyLogger() {
        this.logger = LoggerFactory.getLogger(MyLogger.class);
    }

//    @Before("execution (* *..UserService.save(..))")
//    public void logSignUp(JoinPoint jp) {
//        logsRepository.save(Log.builder()
//                .date(new Date())
//                .info("New user " + Arrays.toString(jp.getArgs()) + "registered")
//                .build());
//    }
}

