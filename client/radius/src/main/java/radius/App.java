package radius;

import org.tinyradius.util.RadiusClient;
import org.tinyradius.util.RadiusEndpoint;
import org.tinyradius.util.RadiusException;

import java.io.IOException;
import java.util.Random;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

public class App
{

    private static String RADIUS_SERVER = "devops-radius.development.landdemon.com";
    private static String SHARED_SECRET = "testing123";
    private static String USERNAME = "user1";
    private static String PASSWORD = "passworduser1";
    private static int NUM_THREADS = 2;
    private static int ITERATIONS_PER_THREAD = 1;
    private static int MAX_SLEEP_MILLIS = 1000;

    public static void main( String[] args ) throws IOException, RadiusException, InterruptedException {

        AtomicInteger numTasksComplete = new AtomicInteger();
        ThreadPoolExecutor threadPoolExecutor = (ThreadPoolExecutor) Executors.newFixedThreadPool(NUM_THREADS);

        System.out.println(String.format("Threads=%d, iterations per thread=%d, mean delay per iteration=%dms. Expected duration=%.1fs, total tests=%d",
                NUM_THREADS, ITERATIONS_PER_THREAD, MAX_SLEEP_MILLIS/2, (double)ITERATIONS_PER_THREAD * MAX_SLEEP_MILLIS / 2 / 1000, NUM_THREADS * ITERATIONS_PER_THREAD));

        long startTime = System.currentTimeMillis();
        for (int t = 0; t < NUM_THREADS; t++) {
            threadPoolExecutor.submit(() -> {
                RadiusClient radiusClient = new RadiusClient(RADIUS_SERVER, SHARED_SECRET);
                Random random = new Random();
                for (int i = 0; i < ITERATIONS_PER_THREAD; i++) {
                    try {
                        Thread.sleep(random.nextInt(MAX_SLEEP_MILLIS));
                        boolean authenticated = radiusClient.authenticate(USERNAME, PASSWORD);
                        System.out.println(String.format("thread=%d, iteration=%d, authenticated=%s, completed=%d", Thread.currentThread().getId(), i, authenticated, numTasksComplete.incrementAndGet()));
                    } catch (InterruptedException | IOException | RadiusException e) {
                        throw new RuntimeException(e);
                    }
                }
            });
        }
        threadPoolExecutor.shutdown();
        threadPoolExecutor.awaitTermination(20, TimeUnit.SECONDS);
        System.out.println(String.format("Elapsed time=%.1fs, tests completed=%d", ((double)System.currentTimeMillis() - startTime) / 1000, numTasksComplete.get()));

    }
}
