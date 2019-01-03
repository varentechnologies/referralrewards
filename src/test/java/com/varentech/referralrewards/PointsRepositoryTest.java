package com.varentech.referralrewards;

import com.varentech.referralrewards.repository.PointsRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static junit.framework.TestCase.assertEquals;


@RunWith(SpringRunner.class)
@SpringBootTest
public class PointsRepositoryTest {
    
    @Autowired
    private PointsRepository pointsRepository;

    /* RULES FOR REFERRAL POINTS

    ** 1 point for any referral made (doubled to 2 points if candidate is fully cleared with technical skillset)
    ** 2 points for any referral which procures an in-person interview (doubled to 4 points if candidate is fully cleared with technical skillset)
    ** 2 points for any referral which receives an offer (doubled to 4 points if candidate is fully cleared with technical skillset)
    ** 4 points for any referral who accepts an offer and starts with Varen (doubled to 8 points if candidate is fully cleared with technical skillset)
    *
    *
    *
    * How descriptions link to database schema:
    *
    * "fully cleared with technical skillset" corresponds to the "clearanceLevel" column in table referralcandidates. If this column is
    * not null, then we assume that the corresponding candidate is fully cleared with technical skillset.
    *
    * "for any referral made" corresponds to the "referralWasMadeOn" column. If a referral has a date value for "referralWasMadeOn", then we
    * assume that the row represents a referral (as opposed to a lead that should be 0 points). A lead becomes a referral once contact has been established
    * with the candidate. The difference between a lead and a referral is the presence of a resume upon initial referral submission.
    *
    * "in-person interview" corresponds to the "interview" column. If a row has a date value on this column, we assume an interview has been established.
    *
    * "offer" corresponds to the "offer" column. If a row has a date value has a date value on this column, we assume an offer has been given to the candidate.
    *
    * "who accepts an offer and starts with varen" corresponds with the "hired" column. If a row has a date value on the "hired" column, we assume the candidate has started with Varen.
    *
    * IMPORTANT NOTE: These conditions do stack. For example, if a referral's candidate procures an in-person interview, receives an offer, and results in a successful hire,
    * then this referral will receive (1 point - referral) + (2 points - interview) + (2 points - offer) + (4 points - hired) for a total of 9 points. If the candidate is also fully cleared
    * with technical skillset, then all point values are doubled and the referral will receive 18 points. This means that the maximum
    * number of points a single referral can receive is 18 points.


     */

    /* Max score test. Employee #7 has a referral that checks all boxes for a single referral so they should have 18 points */
    @Test
    public void test1(){

        /*In data.sql, employee with ID 7 has a referral that has referral, interview, offer, hired, and fully cleared conditions
        should check all boxes. This employee should have the maximum number of points for a single referral - 18 points */
        Long points = pointsRepository.getPointsLastMonthByEmployeeId(new Long(7)); //Find points for employee 7
        Long maxPoints = 18L; //Maximum points a single referral can have

        assertEquals(points,maxPoints); //Checks query result is equal to max points

    }

    /* Edge case test: Employee #2 has a referral (1 point), however the date of "referralWasMadeOn" is Jan 2018.
    Since this date is older than 1 month, they should have 0 points for "points within last month".
     */
    @Test
    public void test2(){

        /* Gets points last month for employee #2 */
        Long points = pointsRepository.getPointsLastMonthByEmployeeId(new Long(2));

        /* Since employee #2's only referral is older than 1 month, they should have 0 points for "points within last month */
        Long expectedPoints = 0L;

        assertEquals(points, expectedPoints);
    }


    /* Tests retrieving map of employee id -> points last month with multiple employee ids (a list of ids) */
    @Test
    public void test3(){
        List<Long> employeeIds = new LinkedList<>();
        employeeIds.add(3L);
        employeeIds.add(5L);
        employeeIds.add(18394L);
        Map<Long,Long> points = pointsRepository.getPointsLastMonthByEmployeeId(employeeIds);

        Map<Long,Long> expectedResult = new HashMap<>();
        expectedResult.put(3L,3L); //Employee #3 has a referral that has an interview. Expected result is 3 (1 point for referral + 2 points for interview)
        expectedResult.put(5L,5L); //Employee #5 has a referral that has an interview and offer. Expected result is 5 (1 point for referral + 2 points for interview + 2 points for offer)
        expectedResult.put(18394L, 0L); //EDGE CASE: Employee #18394 does not exist in the database and should have 0 points

        assertEquals(points, expectedResult);
    }

    /* EDGE CASE TEST: Referrals that are older than a year should not factor into "points within last year" calculation */
    @Test
    public void test4(){

        List<Long> employeeIds = new LinkedList<>();
        employeeIds.add(8L);
        employeeIds.add(10L);
        employeeIds.add(581L); //This employee does not exist and their points last year should be 0
        Map<Long,Long> points = pointsRepository.getPointsLastYearByEmployeeId(employeeIds);

        Map<Long,Long> expectedResult = new HashMap<>();
        expectedResult.put(8L, 1L); //Employee #8 has a single referral without interview, offer, hire, or clearance. Should be just 1 point.
        expectedResult.put(10L, 0L); //Employee #10 has a referral, but it is older than a year. Therefore, they should have 0 points for last year.
        expectedResult.put(581L, 0L); //Employee #581 does not exist and therefore should have 0 points.

        assertEquals(points, expectedResult);
    }

    /* SELECTIVE DOUBLE TEST: tests for referrals that have "fully cleared with technical skillset" and values for a few additional columns, BUT NOT ALL.
    Tests if only select columns without null values receive double points.
     */
    @Test
    public void test5(){
        Long pointsLastMonth = pointsRepository.getPointsLastMonthByEmployeeId(9L);

        /* Employee #9 has a referral with an offer (1 point for referral + 2 points for offer)
        However, since this referral's candidate is fully cleared with technical skillset, all values are doubled.
        Therefore (2 points for referral + 4 points for offer) = 6 points total.
         */
        Long expectedResult = 6L;

        assertEquals(pointsLastMonth, expectedResult);


        //Points last year should be the same as points last month since this referral was made within both last month and year
        Long pointsLastYear = pointsRepository.getPointsLastYearByEmployeeId(9L);
        assertEquals(pointsLastMonth, pointsLastYear);
    }

    /* STACK TEST: tests if an employee that has multiple referrals will have points for all referrals */
    @Test
    public void test6(){

        /* Employee #1 has two referrals. Both referrals have interview, however one referral is fully cleared while the other is not.
        Therefore: expected points for employee #1 is:
        (1 point for referral) + (2 points for interview)
        (2 points for referral - fully cleared) + (4 points for interview fully cleared)
        = 9 points total for both referrals.
         */
        Long pointsLastMonth = pointsRepository.getPointsLastMonthByEmployeeId(1L);
        Long expectedResult = 9L;

        assertEquals(pointsLastMonth, expectedResult);

        Long pointsLastYear = pointsRepository.getPointsLastYearByEmployeeId(1L);

        /* Since both referrals are within 1 month, points last year and points last month should be equal */
        assertEquals(pointsLastMonth, pointsLastYear);
    }

    /* STACK TEST: tests if an employee that has multiple referrals works with multiple id query */
    @Test
    public void test7(){
        List<Long> employeeIds = new LinkedList<>();
        employeeIds.add(1L);
        employeeIds.add(-183L);

        Map<Long,Long> points = pointsRepository.getPointsLastMonthByEmployeeId(employeeIds);

        Map<Long,Long> expectedResult = new HashMap<>();
        expectedResult.put(1L, 9L); //AS above, employee #1 should have 9 points
        expectedResult.put(-183L, 0L); //Employee does not exist and should have 0 points

        assertEquals(points, expectedResult);



    }

    /* EMPTY MAP TEST: passes in an empty list of ids and makes sure query does not break */
    @Test
    public void test8(){
        //Empty list of ids
        List<Long> employeeIds = new LinkedList<>();

        //Gets points last month with empty list
        Map<Long,Long> points = pointsRepository.getPointsLastMonthByEmployeeId(employeeIds);

        //Expected result is an empty map
        Map<Long,Long> expectedResult = new HashMap<>();

        //Asserts equality
        assertEquals(points, expectedResult);
    }

    /* EDGE CASE: makes sure a negative number does not break query */
    @Test
    public void test9(){
        Long points = pointsRepository.getPointsLastMonthByEmployeeId(-4L);
        Long expectedResult = 0L; //A negative number cannot correspond to an employee and therefore should have 0 points
        assertEquals(points,expectedResult);
    }


}
