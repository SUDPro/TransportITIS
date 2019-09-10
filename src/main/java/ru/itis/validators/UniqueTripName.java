package ru.itis.validators;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueTripNameValidator.class)
public @interface UniqueTripName {
    String message() default "Name is already in use";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}