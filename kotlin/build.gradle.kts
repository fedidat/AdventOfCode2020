import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	kotlin("jvm") version "1.4.10"
}

group = "com.fedidat"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_14

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

	implementation(platform("org.jetbrains.kotlin:kotlin-bom"))
	implementation("org.apache.commons:commons-math3:3.5")
	testApi("org.junit.jupiter:junit-jupiter-engine:5.5.2")
	testImplementation("org.assertj:assertj-core:3.11.1")
}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs = listOf("-Xjsr305=strict")
		jvmTarget = "14"
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}

tasks {
	// Use the native JUnit support of Gradle.
	"test"(Test::class) {
		useJUnitPlatform()
	}
}
